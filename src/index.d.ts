type AnimationID = string | number;
type Input = { [key in string]: AnimationID | Animation | Input };
type InputMap = Map<string, AnimationID | Animation | InputMap>;
type AnimationMap = Map<string, Animation | AnimationMap>;

export type AnimationObjects<Input extends {}> = {
	[key in keyof Input]: Input[key] extends AnimationID | Animation ? Animation : AnimationObjects<Input[key]>;
};

export type LoadedTracks<A extends AnimationObjects<{}>> = {
	[key in keyof A]: A[key] extends Animation ? AnimationTrack : LoadedTracks<A[key]>;
};

export declare namespace Animation {
	export const createAnimations: <I extends Input>(animIds: I) => AnimationObjects<I>;
	export const createSlice: (id: AnimationID) => Animation;
	export const loadAnimator: <I extends AnimationObjects<{}>>(animator: Animator, bundle: I) => LoadedTracks<I>;
}
