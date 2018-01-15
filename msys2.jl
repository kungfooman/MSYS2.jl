include("php_trim.jl")

# C:/msys64/mingw64/bin/glfw3.dll

cmd_cmd(command) = Cmd(["cmd.exe", "/c", command])
cmd_bash(command) = Cmd(["C:/msys64/usr/bin/bash.exe", "-c", command])

function spawncmd(cmd::Cmd)
	in = Pipe()
	out = Pipe()
	err = Pipe()
	r = spawn(cmd, (in, out, err))
	close(in);
	close(out.in);
	close(err.in);
	return trim(readstring(out) * readstring(err));
end

function EnvPathForProgramming()
	paths = [
		# for some reason cmd("echo asd") fails with: ERROR: could not spawn `cmd.exe /c 'echo asd'`: no such file or directory (ENOENT)
		# while bash("echo asd") does not... so add system path for cmd(...)
		"C:\\Windows\\System32",
	
		# echo %PATH% for C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64\\vcvars64.bat
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\CommonExtensions\\Microsoft\\TestWindow",
		"C:\\Program Files (x86)\\MSBuild\\14.0\\bin\\amd64",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\BIN\\amd64",
		"C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\VCPackages",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\Tools",
		"C:\\Program Files (x86)\\HTML Help Workshop",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Team Tools\\Performance Tools\\x64",
		"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Team Tools\\Performance Tools",
		"C:\\Program Files (x86)\\Windows Kits\\10\\bin\\x64",
		"C:\\Program Files (x86)\\Windows Kits\\10\\bin\\x86",
		"C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v10.0A\\bin\\NETFX 4.6.1 Tools\\x64",
		
		# for ls.exe etc.
		"C:\\msys64\\usr\\bin"
	];
	
	ENV["PATH"] = join(paths, ";")
end

function cmd(command)
	spawncmd(cmd_cmd(command))
end

function bash(command)
	spawncmd(cmd_bash(command))
end

# todo: make this more dynamic, so I can add stuff like emscripten etc.
EnvPathForProgramming()

#ret = bash("gendef")
#print(ret*ret)

