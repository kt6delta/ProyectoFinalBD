<script setup lang="ts">
definePageMeta({
  layout: "landing",
});

import { useToast } from "primevue/usetoast";
const toast = useToast();

let cod = ref(null);
let salarioMax = ref("");
let salarioMin = ref("");
let nVacantes= ref("");
let descfuncion = ref("");
let descCarreras = ref("");
let FechaReque = ref(null);
let consecReque = ref(null);


const save = () => {
  submit();
};



let message = ref("");
let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);

async function submit() {
  const CODEMPLEADO = localStorage.getItem('CODEMPLEADO');
  try {
    if ( !salarioMax.value || !salarioMin.value || !FechaReque.value || !descfuncion.value || !descCarreras.value || !nVacantes.value) {
      message.value = "Faltan datos";
      isIncomplete.value = true;
      return;
    }
    const route = useRoute();
    await $fetch('/requerimientos/' + route.params.empleado, {
      method: 'POST',
      body: {
        "FECHAREQUE": FechaReque.value,
        "SALARIOMAX": salarioMax.value,
        "SALARIOMIN": salarioMin.value,
        "DESCFUNCION": descfuncion.value,
        "DESCCARRERAS":descCarreras.value,
        "NVACANTES": nVacantes.value
      }
    })
    message.value = "requerimiento creado";
    create.value = true;
  } 
  
  catch (error) {
    console.error('Error during fetch:', error);
    message.value = "Ya existe un requerimiento";
    alredyCreate.value = true;
  }
}

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
          <InputText type="number" placeholder="SalarioMax" v-model="salarioMax" />
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
          <InputText type="number" :min="1" placeholder="nVacantes" v-model ="nVacantes"/>
        </InputGroup>

        <div class="card flex flex-col md:flex-row gap-3">
          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="majesticons:calendar" color="white" size="22" />
            </InputGroupAddon>
            <FloatLabel>
              <label for="label-nacimiento">FechaCreacion </label>
              <Calendar dateFormat="dd/mm/yy" v-model="FechaReque" />
            </FloatLabel>
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
    <InlineMessage v-if="isIncomplete" severity="error">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="alredyCreate" severity="warn">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="create" severity="success">{{ message }}</InlineMessage>
    </div>
</template>