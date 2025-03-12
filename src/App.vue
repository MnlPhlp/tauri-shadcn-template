<script setup lang="ts">
import {onMounted} from 'vue'

import {useStore} from '@/stores/message'
import DarkMode from "./components/DarkMode.vue";
import Greet from "./components/Greet.vue";

onMounted(()=>{
  const store = useStore();
  store.$tauri.start();
})
</script>

<template>
  <DarkMode class="float-right" />
  <div class="w-full h-full flex items-center">
    <Greet />
  </div>
</template>
