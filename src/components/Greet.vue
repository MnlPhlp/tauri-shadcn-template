<script setup lang="ts">
import { ref } from "vue";
import { invoke } from "@tauri-apps/api/core";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

const greetMsg = ref("");
const name = ref("");

async function greet() {
  // Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
  greetMsg.value = await invoke("greet", { name: name.value });
}
function keypress(event: KeyboardEvent) {
  if (event.key === "Enter") greet();
}

</script>

<template>
  <div class="col">
    <div class="row">
      <Input id="greet-input" :onkeypress="keypress" v-model="name" placeholder="Enter a name..." />
      <Button :onclick="greet">Greet</Button>
    </div>
    <p class="mt-2">
      {{ greetMsg }}
    </p>
  </div>
</template>
