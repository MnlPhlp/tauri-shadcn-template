<script setup lang="ts">
import { ref } from "vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { commands } from "@/bindings";

const greetMsg = ref("");
const name = ref("");

async function greet() {
  greetMsg.value = await commands.greet(name.value);
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
