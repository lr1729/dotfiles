define sv
  set $vars = $arg0
  dv
end

define ud
  undisplay

end

define dv
python
vars = str(gdb.convenience_variable("vars"))[1:-1].split()
for word in vars:
  gdb.execute("display " + word)
end
display
end

define pv
python
vars = str(gdb.convenience_variable("vars"))[1:-1].split()
for word in vars:
  gdb.execute("print " + word)
end
end
