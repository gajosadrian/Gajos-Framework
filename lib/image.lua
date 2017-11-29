images = {
	user = {};
}
for i = 1, 32 do
	images.user[i] = {}
end

_image = image
function image(path, x, y, mode, pl)
	local imageid = _image(path, x, y, mode, pl)
	local pl = pl or 0
	
	if (pl > 0) then
		table.insert(images.user[pl], imageid)
	elseif (mode >= 101 and mode <= 132) or (mode >= 201 and mode <= 232) or (mode >= 133 and mode <= 164) then
		local pl = tonumber(tostring(mode):sub(2,3))
		pl = pl > 32 and pl - 32 or pl
		
		table.insert(images.user[pl], imageid)
	end

	return imageid
end

local function removeImage(imageid)
	for _, v in pairs(images.user) do
		for k, i in pairs(v) do
			if i == imageid then
				table.remove(v, k)
				return
			end
		end
	end
end

_freeimage = freeimage
function freeimage(imageid)
	if imageid then
		removeImage(imageid)
		_freeimage(imageid)
	end
end

function images.Remove(id)
	for i, v in pairs(images.user[id]) do
		_freeimage(v)
	end
	images.user[id] = {}
end