-- Simple distance between two points
function math.distance (x1, y1, x2, y2)
	return(math.sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)))
end

-- Milliseconds to measure time
function Millisecs()
	return(os.clock() * 1000)
end

-- Remove item from the table
function table.removeByValue(list, v)
	for k,id in pairs(list) do
		if (id == v) then
			table.remove(list, k)
			break
		end
	end
end

-- Lineal interpolation
function math.lerp(a, b, t)
	return a + (b - a) * t
end

-- Simple color class
TColor = {}
function TColor.White()
	return({r = 255, g = 255, b = 255})
end

-- Functions to simplify some of the code
TDebug = {}
function TDebug.Null(value, set)
	if (value == nil) then
		return(set)
	end
	return(value)
end

function TDebug.ArgError(func, str1, arg1, str2, arg2, str3, arg3)
	if (str1 and arg1 == nil) then
		print("LUA IMAGE ERROR: "..func..' is missing '..str1..' value (file: '..__FILE__()..' line: '..__LINE__()..")")
		return(true)
	end
	if (str2 and arg2 == nil) then
		print("LUA IMAGE ERROR: "..func..' is missing '..str2..' value (file: '..__FILE__()..' line: '..__LINE__()..")")
		return(true)
	end
	if (str3 and arg3 == nil) then
		print("LUA IMAGE ERROR: "..func..' is missing '..str3..' value (file: '..__FILE__()..' line: '..__LINE__()..")")
		return(true)
	end
	if (str4 and arg4 == nil) then
		print("LUA IMAGE ERROR: "..func..' is missing '..str4..' value (file: '..__FILE__()..' line: '..__LINE__()..")")
		return(true)
	end
	return(false)
end

-- Handy function for simple flags
function TFlags(...)
	local f = {}
	for i,v in ipairs(arg) do
		table.insert(f, tonumber(v))
	end
	return(f)
end

function __FILE__()
  return debug.getinfo(4,'S').source
end
function __LINE__() 
	return debug.getinfo(4, 'l').currentline 
end