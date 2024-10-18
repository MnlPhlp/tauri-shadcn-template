<script setup lang="ts">
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://vuejs.org/api/sfc-script-setup.html#script-setup
import DarkMode from "./components/DarkMode.vue";
import Greet from "./components/Greet.vue";
</script>

<template>
  <DarkMode class="float-right" />
  <div class="w-full h-full flex items-center">
    <Greet />
  </div>
</template>
