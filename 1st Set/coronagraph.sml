open Array

fun printer (input: int list) =
    let
        fun pri nil     = print ("\n")
          | pri (h::[]) = (print(Int.toString(h)); pri [])
          | pri (h::t)  = (print(Int.toString(h) ^ " "); pri t)
    in
        pri input
    end;
    
fun sum_list(xs: int list)=
if null xs
then 0 
else hd xs+ sum_list(tl xs);

fun merge_list( L :int list) = ListMergeSort.sort(fn (x:int,t)=> x>t)(L);

fun count_the_nodes a [] array_of_circle L = L
          | count_the_nodes a (x::LL) array_of_circle L =
            let
                fun length x =
                    let
                        val s = ref 1
                        fun transition x parent =
                            let
                                val _ = (s := (!s + 1))
                                fun dfs2 [] = ()
                                  | dfs2 (h::L) = 
                                    let
                                        val _ = if h <> parent then transition h x
                                                else ()
                                    in
                                        dfs2 L
                                    end
                                val qq = sub (a, x)
                                val _ = dfs2 qq
                            in
                                ()
                            end
                        fun dfs3 [] = ()
                          | dfs3 (h::L) =
                            let
                                val list_of_circle = sub (array_of_circle, h)
                                val _ = if list_of_circle then ()
                                        else transition h x
                            in
                                dfs3 L
                            end
                        val qq = sub (a, x)
                        val _ = dfs3 qq
                    in
                        !s
                    end
                val z = length x
            in
                count_the_nodes a LL array_of_circle (z::L)
            end
        
fun coronograph file =
    let
        fun corona a N =
            let
                
                val cycle = ref []
                val stop = ref false
              
              fun check_all_elements dd i =
                    let
                        val check = sub (dd, i)
                    in
                        if (check=false) then false
                        else if ((i+1)=N) then true
                        else check_all_elements dd (i+1)

                    end
                val visited_array = array (N, false)
                val parent_array = array (N, 0)
                val exit = array (N, false)

                fun createcycle x y L =
                    let
                        val hh = sub (parent_array, x)
                    in
                        if x=y then cycle := L
                        else createcycle hh y (x::L)
                    end

                fun dfs x =
                    let
                        fun call_dfs [] = ()
                          | call_dfs (g::L) =
                                let
                                    val vv = sub (visited_array, g)
                                    val ee = sub (exit, g)
                                    val pp = sub (parent_array, x)
                                    val _ = if ((vv = false) andalso (!stop = false)) then update (parent_array, g, x)
                                            else ()
                                    val _ = if (vv = false) then dfs g
                                            else if ((!stop = false) andalso (ee = false) andalso (g <> pp)) then createcycle x g [g]
                                            else ()
                                in
                                    call_dfs L
                                end
                        val _ = update(visited_array, x, true)
                        val qq = sub(a, x)
                        val _ = call_dfs qq
                        val _ = update(exit, x, true)

                    in
                        ()
                    end
                   val _ = dfs 0
             in   
                
                if (check_all_elements visited_array 0) then !cycle
                else []
            end
        
        
                
        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        val inStream = TextIO.openIn file
        val T = readInt inStream
        val _ = TextIO.inputLine inStream

        fun looper q =
            let
                val N = readInt inStream
                val M = readInt inStream
                val _ = TextIO.inputLine inStream
                val a = array (N, [])
                 fun add_edge u =
                    let
                        val i = (readInt inStream - 1)
                        val j = (readInt inStream - 1)
                        val _ = TextIO.inputLine inStream
                        val k = sub (a, i)
                        val l = sub (a, j)
                        val _ = update (a, i, j::k)
                        val _ = update (a, j, i::l)
                    in
                        if u = 1 then ()
                        else add_edge (u-1)
                    end
                val _ = add_edge M
                val array_of_circle = array(N, false)
                val l = if N = M then corona a N
                        else []
                val list_of_circle = List.length l
                
                fun bnodes [] = ()
                  | bnodes (r::L) =
                    let
                        val _ = update (array_of_circle, r, true)
                    in
                        bnodes L
                    end
                val _ = bnodes l
                val t = if list_of_circle = 0 then []
                        else merge_list (count_the_nodes a l array_of_circle [])
                
                val sum = sum_list(t)
                
                val _ = if (list_of_circle = 0 orelse sum <> M ) then print("NO CORONA\n")
                        else ( print("CORONA " ^ (Int.toString list_of_circle) ^ "\n"); printer(t) )
                    
            in
                if q = 1 then ()
                else looper (q-1)
            end
    in
        looper T
    end;