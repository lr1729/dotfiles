define sv
  set $n = 1
  set $vars = $arg0
  while $n < $argc
    eval "set $var = $arg%d", $n
    p $var
    eval "set $vars = \"%s %s\"", $vars, $var
    set $n = $n + 1
  end
end

define pv
  set $n = 0
  while $n < $vars
    eval "print $arg%d", $n
    set $n = $n + 1
  end
end
