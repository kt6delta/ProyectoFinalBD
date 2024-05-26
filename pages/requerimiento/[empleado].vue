<script setup lang="ts">
definePageMeta({
  layout: "landing",
});

import { useToast } from "primevue/usetoast";
const toast = useToast();

let cod = ref(null);
let salarioMax = ref("");
let salarioMin = ref("");
let numeroVacantes= ref("");
let descfuncion = ref("");
let descCarreras = ref("");



const save = () => {
  toast.add({ severity: 'success', summary: 'Success', detail: 'Data Saved', life: 3000 });
};

import { ref } from "vue";

let cargos = ref([await $fetch('/cargos')]);
cargos=cargos.value[0];

</script>

<template>
    <Card class="mt-[5vh]" style="overflow: hidden">
      <template #header>
        <LandingSectionhead>
          <template v-slot:title>Crear Requerimiento</template>
          <template v-slot:desc>We find the best people.<br> fecha:</template>
        </LandingSectionhead>
      </template>
      <template #content>
        <div class="grid md:grid-cols-2 gap-10 mx-auto max-w-4xl mt-16">
          <!-- input General -->
          <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="number" :min="0" placeholder="ConsecReque" v-model="cod" />
        </InputGroup>

          <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="numer" placeholder="SalarioMax" v-model="salarioMax" />
        </InputGroup>

        <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="number" placeholder="SalarioMin" v-model="salarioMin"/>
        </InputGroup>

        <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="text" placeholder="DescFuncion" v-model="descfuncion" @input="descfuncion = descfuncion.toLowerCase()" />
        </InputGroup>

        <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="text" placeholder="DescCarreras" v-model="descCarreras" @input="descCarreras = descCarreras.toLowerCase()" />
        </InputGroup>

        <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="number" :min="1" placeholder="numeroVacantes" v-model ="numeroVacantes"/>
        </InputGroup>

          <!-- input pequeños -->
          <div class="card flex flex-col md:flex-row gap-3">

            <InputGroup>
              <InputGroupAddon class="bg-black text-white">
                <Icon name="majesticons:calendar" color="white" size="22" />
              </InputGroupAddon>
              <Calendar dateFormat="dd/mm/yy" />
              <InputText placeholder="FechaCreacion" />
            </InputGroup>

          </div>

        </div>
      </template>
      <template #footer>
        <div class="flex justify-center align-middle gap-3 mt-1">
          <SplitButton label="Save" @click="save" rounded severity="contrast"
            class="text-white bg-black px-2 py-2"></SplitButton>
        </div>
      </template>
    </Card>
    <div class="card flex flex-wrap items-center justify-center gap-3 mt-16">
      <InlineMessage severity="success">Success Message</InlineMessage>
      <InlineMessage severity="warn">Warning Message</InlineMessage>
      <InlineMessage severity="error">Error Message</InlineMessage>
    </div>
</template>