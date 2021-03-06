local Animation = { _animations = {} }
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
			elseif inputType == "table" then
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

	function Animation.loadAnimator(animator, bundle)
		local animations = {}
		for key, value in pairs(bundle) do
			local inputType = typeof(value)
			if inputType == "Instance" and value:IsA("Animation") then
				local animation = animator:LoadAnimation(value)
				animations[key] = animation
			elseif inputType == "table" then
				animations[key] = Animation.loadAnimator(animator, value)
			end
		end
		return animations
	end
end
return { Animation = Animation }
