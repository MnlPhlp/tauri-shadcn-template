<script setup lang="ts">
import { ref } from "vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { commands } from "@/bindings";

import {useStore} from '@/stores/message'

const greetMsg = ref("");
const name = ref("");
const store = useStore();

async function greet() {
  greetMsg.value = await commands.greet(name.value);
}

function keypress(event: KeyboardEvent) {
  if (event.key === "Enter") greet();
}

async function greetFromStore() {
    await commands.greetFromStore();
    console.log('msg:', store.greetMsg)
}

function keypressStore(event: KeyboardEvent) {
    if (event.key === "Enter") greetFromStore();
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
    <!-- use store for the messages as an example for a store-->
    <div class="row mt-4">
        <Input
            id="greet-input-store"
            placeholder="Enter a name..."
            :onkeypress="keypressStore"
            v-model="store.name"
        />
        <Button :onclick="greetFromStore">Greet from store</Button>
    </div>
    <p class="mt-2">
    {{store.greetMsg}}
    </p>
  </div>
</template>
