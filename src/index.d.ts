type AnimationID = string | number;
type Input = { [key in string]: AnimationID | Animation | Input };
type InputMap = Map<string, AnimationID | Animation | InputMap>;
type AnimationMap = Map<string, Animation | AnimationMap>;
type AnimationObject<Input> = {
	[key in keyof Input]: Input[key] extends AnimationID | Animation ? Animation : AnimationObject<Input[key]>;
};
type TrackObject<Input> = {
	[key in keyof Input]: Input[key] extends Animation ? AnimationTrack : TrackObject<Input[key]>;
};

export declare namespace Animation {
	export const createAnimations: <I extends Input>(animIds: I) => AnimationObject<I>;
	export const createSlice: (id: AnimationID) => Animation;
	export const loadAnimator: <I extends AnimationObject<{}>>(animator: Animator, bundle: I) => TrackObject<I>;
}
