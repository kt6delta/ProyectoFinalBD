<script setup>
import { ref } from "vue";
import { Icon } from '#components';

const props = defineProps({
  Propempleado: String
});

let empleado = ref(props.Propempleado);
const items = ref([
  {
    label: empleado.value,
    root: true
  }
]);
</script>

<template>
  <LandingContainer>
    <div class="card">
      <MegaMenu :model="items" class="p-4 bg-surfrace-0 dark:bg-surface-900 shadow-md" style="border-radius: 3rem">
        <template #start>
          <div class="ml-[1vw]">        
            <Avatar label="U" size="xlarge" class="mr-2" style="background-color: #000000; color: #ffffff" shape="circle" />
        </div>
        </template>
        <template #item="{ item }">
          <a v-if="item.root" v-ripple
            class="flex justify-center items-center cursor-pointer px-3 py-2 overflow-hidden relative font-semibold text-xl uppercase"
            style="border-radius: 2rem;">
            <span class="ml-2">{{ item.label }}</span>
          </a>
        </template>
        <template #end>
          <a href="/" class="text-lg"><span class="font-bold text-slate-800">Company</span><span
              class="text-slate-500">Job</span>
              <Icon name="hugeicons:new-job" color="currentColor" size="48"/>
          </a>    
        </template>
      </MegaMenu>
    </div>
  </LandingContainer>
</template>
