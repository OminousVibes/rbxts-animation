# @rbxts/animation
### Animation Generation and Utility for TS
`@rbxts/animation` is inspired by Flameworks networking package and streamlines the process of creating, and loading 

##### Features:
- Generating Animations in a single, or multiple file if so wished.
- Preloading animations using ContentProvider:PreloadAsync
- Utility for calling Animator:LoadAnimation() on every animation.

##### Example:
```TS
import { Animation } from "@rbxts/animation";

const Bundle = Animation.createAnimations({
	idle: 1234,
	walk: "rbxassetid://1234",
	others: {
		idle: 1234,
		walk: "rbxassetid://1234",
	},
	sliceExample: Animation.createSlice("rbxassetid://1234"),
});

Animation.preload().then(() => {
	print("Preload complete");
});
Animation.loadAnimator(undefined! as Animator, Bundle).idle.Play();

```