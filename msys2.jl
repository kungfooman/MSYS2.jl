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

cmd(command) = spawncmd(cmd_cmd(command))
bash(command) = spawncmd(cmd_bash(command))

#ret = bash("gendef")
#print(ret*ret)

