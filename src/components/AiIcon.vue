<template>
  <svg
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    stroke-width="1.6"
    stroke-linecap="round"
    stroke-linejoin="round"
    aria-hidden="true"
  >
    <template v-if="name === 'agents'">
      <path d="M5 5.5h14a2 2 0 0 1 2 2V15a2 2 0 0 1-2 2h-6l-4 3.5V17H5a2 2 0 0 1-2-2V7.5a2 2 0 0 1 2-2Z" />
      <path d="M8 10.25h.01M12 10.25h.01M16 10.25h.01" stroke-width="2.4" />
    </template>
    <template v-else-if="name === 'voice'">
      <path d="M4 12v.01M8 8.5v7M12 4.5v15M16 8.5v7M20 11v2" />
    </template>
    <template v-else-if="name === 'knowledge'">
      <path d="M5 6c0-1.66 3.13-3 7-3s7 1.34 7 3-3.13 3-7 3-7-1.34-7-3Z" />
      <path d="M5 6v6c0 1.66 3.13 3 7 3s7-1.34 7-3V6M5 12v6c0 1.66 3.13 3 7 3s7-1.34 7-3v-6" />
    </template>
    <template v-else>
      <circle cx="7" cy="5.5" r="2.5" />
      <circle cx="7" cy="18.5" r="2.5" />
      <circle cx="17" cy="9" r="2.5" />
      <path d="M7 8v8M17 11.5c0 3.5-10 1.5-10 4.5" />
    </template>
  </svg>
</template>

<script setup>
defineProps({
  name: { type: String, required: true }
});
</script>
