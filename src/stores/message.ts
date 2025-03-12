import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useStore = defineStore("message", {
	state: () => {
		return {
			name: ref(''),
			greetMsg: ref(''),
		}
	},
	tauri: {
		syncStrategy: 'debounce',
		syncInterval: 100,
	}
})
