define sv
  set $vars = $arg0
end

define dv
  p $displayVars($vars)
end

define pv
  p $printVars($vars)
end

python
class DVars (gdb.Function):
  def __init__ (self):
    super (DVars, self).__init__("displayVars")
  def invoke (self, string):
    vars = str(string)[1:-1].split()
    for word in vars:
      gdb.execute("display " + word)
    return "Tracking variables " + str(string)[1:-1]
DVars()
class PVars (gdb.Function):
  def __init__ (self):
    super (PVars, self).__init__("printVars")
  def invoke (self, string):
    vars = str(string)[1:-1].split()
    for word in vars:
      gdb.execute("print " + word)
    return ""
PVars()


