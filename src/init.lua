local TS = _G[script]
local ContentProvider = game:GetService("ContentProvider")

local Animation = { _animations = {}, }
do
	function Animation.createAnimations(animIds)
		local animations = {}
		for key, value in pairs(animIds) do
			local inputType = typeof(value)
			if inputType == "string" or type(value) == "number" then
				local animation = Animation.createSlice(value)
				animations[key] = animation
				table.insert(Animation._animations, animation)
			elseif inputType == "Instance" and value:IsA("Animation") then
				local animation = value
				animations[key] = animation
				table.insert(Animation._animations, animation)
			elseif type(value) == "table" then
				animations[key] = Animation.createAnimations(value)
			end
		end
		return animations
	end

	function Animation.createSlice(id)
		local animation = Instance.new("Animation")
		animation.AnimationId = if type(id) == "string" then id else "rbxassetid://" .. tostring(id)
		return animation
	end

	function Animation.preloadAsync()
		TS.Promise.new(function(resolve, reject)
			local success = {}
			local failed = {}
			ContentProvider:PreloadAsync({ Animation._animations }, function(id, status: Enum.AssetFetchStatus)
				if status == Enum.AssetFetchStatus.Success then
					table.insert(success, id)
				else
					table.insert(failed, id)
				end
			end)
			return resolve({
				success = #success,
				failed = #failed,
			})
		end)
	end

	function Animation.loadAnimator(animator: Animator, bundle)
		local animations = {}
		for key, value in pairs(bundle) do
			local inputType = typeof(value)
			if inputType == "Instance" and value:IsA("Animation") then
				local animation = animator:LoadAnimation(value)
				animations[key] = animation
				table.insert(Animation._animations, animation)
			elseif type(value) == "table" then
				animations[key] = Animation.loadAnimator(value)
			end
		end
		return animations
	end
end
return { Animation = Animation }
