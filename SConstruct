#!python

import os, platform


def add_source(sources, name):
  sources.append(name)

def add_sources(sources, dir, extension):
  for f in os.listdir(dir):
      if f.endswith('.' + extension):
          sources.append(dir + '/' + f)


env = Environment()
host_platform = platform.system()
target_platform = ARGUMENTS.get('p', ARGUMENTS.get('platform', 'linux'))
target_arch = ARGUMENTS.get('a', ARGUMENTS.get('arch', '64'))
# default to debug build, must be same setting as used for cpp_bindings
target = ARGUMENTS.get('target', 'debug')
# Local dependency paths, adapt them to your setup
cpp_bindings = ARGUMENTS.get('cpp_bindings', '../godot-cpp')
godot_headers = ARGUMENTS.get('headers', '../godot_headers')
result_path = 'bin'
result_name = ARGUMENTS.get('n', ARGUMENTS.get('name', os.path.relpath('.', '..')))


if target_platform == 'linux':
  result_name += '.linux.' + target_arch

  env['CXX']='gcc-5'
  env.Append(CCFLAGS = [ '-fPIC', '-g', '-O3', '-std=c++14', '-Wwrite-strings' ])
  env.Append(LINKFLAGS = [ '-Wl,-R,\'$$ORIGIN\'' ])

  if target_arch == '32':
    env.Append(CCFLAGS = [ '-m32' ])
    env.Append(LINKFLAGS = [ '-m32' ])
  elif target_arch == '64':
    env.Append(CCFLAGS = [ '-m64' ])
    env.Append(LINKFLAGS = [ '-m64' ])

elif target_platform == 'windows':
  result_name += '.windows.' + target_arch

  if host_platform == 'Windows':
    result_name += '.dll'

    env.Append(LINKFLAGS = [ '/WX' ])
    if target == 'debug':
      env.Append(CCFLAGS = ['-EHsc', '-D_DEBUG', '/MDd' ])
    else:
      env.Append(CCFLAGS = ['-O2', '-EHsc', '-DNDEBUG', '/MD' ])
  else:
    if target_arch == '32':
      env['CXX']='i686-w64-mingw32-g++'
    elif target_arch == '64':
      env['CXX']='x86_64-w64-mingw32-g++'

    env.Append(CCFLAGS = [ '-g', '-O3', '-std=c++14', '-Wwrite-strings' ])
    env.Append(LINKFLAGS = [ '--static', '-Wl,--no-undefined', '-static-libgcc', '-static-libstdc++' ])

elif platform == 'osx':
  env.Append(CCFLAGS = [ '-g','-O3', '-std=c++14', '-arch', 'x86_64' ])
  env.Append(LINKFLAGS = [ '-arch', 'x86_64', '-framework', 'Cocoa', '-Wl,-undefined,dynamic_lookup' ])


env.Append(CPPPATH = [ 'src', 'include', godot_headers, cpp_bindings + '/include', cpp_bindings + '/include/core' ])
env.Append(LIBS = [ 'godot-cpp.' + target_platform + '.' + target_arch ])
env.Append(LIBPATH = [ cpp_bindings + '/include', cpp_bindings + '/bin', 'lib' ])
SConscript('SConscript', 'env target_platform target_arch host_platform')


sources = []
add_sources(sources, 'src', 'cpp')


library = env.SharedLibrary(target=result_path + '/' + result_name, source=sources)
Default(library)