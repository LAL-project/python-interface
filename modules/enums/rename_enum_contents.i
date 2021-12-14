%pythoncode %{
__mod = __import__(__mod_name)
__replace_length = len(__to_replace)
for name in dir(__mod):
    if name.find(__to_replace) == 0:
        setattr(__mod, name[__replace_length:], getattr(__mod, name))
        delattr(__mod, name) # optional
del name
del __mod, __mod_name
del __to_replace, __replace_length
%}
