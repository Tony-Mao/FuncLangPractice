(* Hongzi Mao hmao 2002 5238 *)

datatype 'a ht =  table of (int * ('a list)) list; 

(*1*)
fun lookup key (table nil) = [] |
lookup key (table((entry,lst)::tail)) = 
if key = entry then lst 
else lookup key (table(tail));

(*2*)
fun join (table(lst1)) (table(lst2)) = table(lst1@lst2);

fun exist_in_lst nil elt = false |
exist_in_lst (h::t) elt = if h = elt then true 
else exist_in_lst t elt;

fun tryappend lst elt = 
if exist_in_lst lst elt then lst
else elt::lst;

fun insert (key, elt) (table nil) = (table[(key, [elt])]) |
insert (key, elt) (table((entry,lst)::tail)) = 
if key = entry 
then table((entry, tryappend lst elt)::tail) 
else join (table[(entry,lst)]) (insert (key, elt) (table(tail)));

(*3*)
fun count nil = 0 |
count (h::t) = 1 + count t;

fun sumup (key, lst) = (key, count lst);

fun valuecount (table nil) = [] |
valuecount (table(lst)) = map sumup lst;

(*4*)
fun take lst = 
    if lst = nil then nil
    else hd(lst)::jump(tl(lst))
and jump lst = 
    if lst = nil then nil
    else take(tl(lst));

fun merge(nil, R) = R |
    merge(L, nil) = L |
    merge((k1, v1)::t1, (k2, v2)::t2) = 
	if (v1>v2) then ((k1,v1)::merge(t1,(k2,v2)::t2))
                   else ((k2,v2)::merge((k1,v1)::t1,t2));

fun sort(lst) = 
    if lst = nil then nil
    else if tl(lst) = nil then lst
    else merge(sort(take(lst)), sort(jump(lst)));

fun hotkeys ht =
    let val vc = (valuecount ht) 
    in
      sort(vc)
    end;

(*5*)
fun remove_negative nil = [] |
remove_negative (h::t) =
 if (h>=0) then (h::remove_negative t) 
 else (remove_negative t);

fun remove_negative_tuple (elt, lst) = (elt, remove_negative lst);

fun match_positive (elt, nil) = [] |
match_positive (elt, h::t) = (elt, h)::(match_positive (elt, t)); 

fun match_positive_lst nil = [] |
match_positive_lst (h::t) = (match_positive h)@(match_positive_lst t);

fun positivekvs (table nil) = [] |
positivekvs (table(lst)) = 
let val positive_lst = map remove_negative_tuple lst in 
  match_positive_lst positive_lst 
end;

