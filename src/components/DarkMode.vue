<script setup lang="ts">
import { Button } from '@/components/ui/button'
import { Icon } from '@iconify/vue'
import { useColorMode } from '@vueuse/core'

// Pass  to enable transitions
const mode = useColorMode({ disableTransition: false })

function toggle() {
    if (mode.value === "dark") mode.value = "light"
    else mode.value = "dark"
}
</script>

<template>
    <Button variant="outline" :onclick="toggle">
        <Icon icon="radix-icons:moon" class="h-[1.2rem] w-[1.2rem] scale-100 transition-all dark:scale-0" />
        <Icon icon="radix-icons:sun" class="absolute h-[1.2rem] w-[1.2rem] scale-0 transition-all dark:scale-100" />
        <span class="sr-only">Toggle theme</span>
    </Button>
</template>
