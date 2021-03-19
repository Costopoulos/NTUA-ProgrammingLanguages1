open Array

fun stayhome file =
    let
        val S = ref 0
        val T = ref 0
        val W = ref 0
        val A = ref []
        val inStream = TextIO.openIn file
        val s = TextIO.inputAll inStream
        fun columns i =
            let
                val character = String.sub (s, i)
            in
                if character = #"\n" then i
                else columns (i+1)
            end
        val M = columns 0
        val N = ((size s) div (M+1))
        val siz = size(s) -1
        val vir = array ((size s), 0)
        val visited = array ((size s), 0)
        val path = array ((siz+1), "None")
        
        fun declare i =
            let
                val elem = String.sub(s,i)
                val _ = if elem = #"W" then (W:=i)
                        else if elem = #"A" then (A:=(i::(!A)))
                        else if elem = #"S" then (S:=i)
                        else if elem = #"T" then (T:=i)
                        else ()
            in
                if i = siz then ()
                else declare (i+1)
            end
        
        val _ = declare 0
    
        fun move_up x =
            let
                val z = (x-M-1)
            in
                if z < 0 then ~1
                else if ( (String.sub(s,z) = #"X") orelse (String.sub(s,z) = #"W") orelse (String.sub(s,x) = #"X") orelse (String.sub(s,x) = #"\n") ) then ~1
                else z
            end
            
        fun move_down x =
            let
                val z = (x+M+1)
            in
                if z > siz then ~1
                else if ( (String.sub(s,x)= #"X") orelse (String.sub(s,z)= #"X") orelse (String.sub(s,x)= #"\n") orelse (String.sub(s,z)= #"W") ) then ~1
                else z
            end
            
        fun move_left x =
            let
                val z = (x mod (M+1))
            in
                if z = 0 then ~1
                else if ( (String.sub(s,x)= #"X") orelse (String.sub(s,x-1)= #"X") orelse (String.sub(s,x-1)= #"\n") orelse (String.sub(s,x-1)= #"W") ) then ~1
                else x-1
            end
            
        fun move_right x = 
            let
                val z = x mod (M+1)
            in
                if z = M-1 then ~1
                else if ( (String.sub(s,x)= #"X")  orelse (String.sub(s,x+1)= #"X") orelse (String.sub(s,x+1)= #"W") orelse (String.sub(s,x+1)= #"\n")) then ~1
                else x+1
            end
            
        val b = List.rev(!A)
        val a = Array.fromList (b)
        
        fun move_virus (a) (N) (x) (n) = 
            
            let
                val u = move_up x
                val d = move_down x
                val l = move_left x
                val r = move_right x
                val _ = if(sub(vir,x) = 0 orelse n < sub(vir,x)) then ((update(vir,x,n));
                (if(d <> ~1) then (if( String.sub(s, x+M+1) <> #"A") then (move_virus (a) (N) (x+M+1) (n+2))
                    else(
                                let
                                    fun aero  (a) (~1) = ()
                                        |aero (a) (N) =  
                                        let 
                                            
                                            val _ = if( sub(a, N) <> x+M+1 )
                                            then ((move_virus (a) (N) (sub(a, N)) (n+7)); 
                                            (move_virus (a) (N) (x+M+1) (n+2))
                                            ) 
                                            else( aero (a) (N-1) )
                                             
                                        in
                                            aero (a) (N-1)
                                        end
                                in
                                    aero (a) (N)
                                end
                            )
                        )
                    else()
                    );
                    (if(l <> ~1) then (if( String.sub(s, x-1) <> #"A") then (move_virus (a) (N) (x-1) (n+2))
                    else(
                                let
                                    fun aero  (a) (~1) = ()
                                        |aero (a) (N) =  
                                        let 
                                            
                                            val _ = if( sub(a, N) <> x-1 )
                                            then ((move_virus (a) (N) (sub(a, N)) (n+7)); 
                                            (move_virus (a) (N) (x-1) (n+2))
                                            ) 
                                            else( aero (a) (N-1) )
                                             
                                        in
                                            aero (a) (N-1)
                                        end
                                in
                                    aero (a) (N)
                                end
                            )
                        )
                    else()
                    );
                    (if(r <> ~1) then (if( String.sub(s, x+1) <> #"A") then (move_virus (a) (N) (x+1) (n+2))
                    else(
                                let
                                    fun aero  (a) (~1) = ()
                                        |aero (a) (N) =  
                                        let 
                                            
                                            val _ = if( sub(a, N) <> x+1 )
                                            then ((move_virus (a) (N) (sub(a, N)) (n+7)); 
                                            (move_virus (a) (N) (x+1) (n+2))
                                            ) 
                                            else( aero (a) (N-1) )
                                             
                                        in
                                            aero (a) (N-1)
                                        end
                                in
                                    aero (a) (N)
                                end
                            )
                        )
                    else()
                    );
                    (if(u <> ~1) then (if( String.sub(s, x-M-1) <> #"A") then (move_virus (a) (N) (x-M-1) (n+2))
                    else(
                                let
                                    fun aero  (a) (~1) = ()
                                        |aero (a) (N) =  
                                        let 
                                            
                                            val _ = if( sub(a, N) <> x-M-1 )
                                            then ((move_virus (a) (N) (sub(a, N)) (n+7)); 
                                            (move_virus (a) (N) (x-M-1) (n+2))
                                            ) 
                                            else( aero (a) (N-1) )
                                             
                                        in
                                            aero (a) (N-1)
                                        end
                                in
                                    aero (a) (N)
                                end
                            )
                        )
                    else()
                    )
                    )
                    else()
                in
                    ()
                end	
    
        val _ = move_virus (a) (length(a)-1) (!W) (0) 
        
    fun move_sotos n [] = ()
          | move_sotos n L =
            let
                    
                fun spread_sotos [] Ns = Ns
                  | spread_sotos (x::L) Ns =
                    let
                        val u = move_up x
                        val d = move_down x
                        val l = move_left x
                        val r = move_right x
                        val visu = if u = ~1 then ~1
                                    else sub (visited, u)
                        val visd = if d = ~1 then ~1
                                    else sub (visited, d)
                        val visl = if l = ~1 then ~1
                                    else sub (visited, l)
                        val visr = if r = ~1 then ~1
                                    else sub (visited, r)
                        val sotosdown = if (visd = 0 andalso n < sub(vir,d)) then [d]
                                    else []
                        val sotosleft = if (visl = 0 andalso n < sub(vir,l)) then [l]
                                    else []
                        val sotosright = if (visr = 0 andalso n < sub(vir,r)) then [r]
                                     else []
                        val sotosup = if (visu = 0 andalso n < sub(vir,u)) then [u]
                                  else []
                        val _ = if sotosdown = [d] then (update (visited, d, n), update (visited, !S, ~1), update (path, d, "D"))
                                else ((),(), ())
                        val _ = if sotosleft = [l] then (update (visited, l, n),update (visited, !S, ~1), update (path, l, "L"))
                                else ((),(), ())
                        val _ = if sotosright = [r] then (update (visited, r, n), update (visited, !S, ~1), update (path, r, "R"))
                                else ((),(), ())
                        val _ = if sotosup = [u] then (update (visited, u, n), update (visited, !S, ~1), update (path, u, "U"))
                                else ((),(), ())
                        val spreaded_sotos = (((sotosdown @ sotosleft) @ sotosright) @sotosup)
                    in
                        spread_sotos L (Ns @ spreaded_sotos)
                    end
                
                val newL = spread_sotos L []
            in
                move_sotos (n+1) newL
            end
        
        val _ = move_sotos 1 [!S]
        
        val moves = sub (visited, !T)
        val _ = if moves = 0 then print ("IMPOSSIBLE")
                else print (Int.toString moves)
        val _ = print ("\n")
        
        
        fun print_output chara x =
            let
                val dir = sub (path, x)
                val parent = if dir = "D" then (x-M-1)
                        else if dir = "L" then (x+1)
                        else if dir = "R" then (x-1)
                        else if dir = "U" then (x+M+1)
                        else 0
            in
                if dir = "None" then chara
                else print_output (dir ^ chara) parent
            end
            
        val way = if moves = 0 then ""
                   else print_output "\n" (!T)
        val _ = if moves = 0 then ()
                else print (way) 
        
    
    in
        ()
    end