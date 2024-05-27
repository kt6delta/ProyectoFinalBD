<script setup lang="ts">
definePageMeta({
  layout: "landing",
});
import InputsRequerimiento from '@/components/InputsRequerimiento.vue';

const save = () => {
  submit();
};


<<<<<<< HEAD
const updateCod = (newVal:any) => {
  cod.value = newVal
}
=======
let salarioMax = ref("")
let salarioMin = ref("")
let nVacantes = ref("")
let descfuncion = ref("")
let descCarreras = ref("")
let FechaReque = ref(null)

>>>>>>> 86410b388d8afae0b1950c0d7e7613ccf3c3e377
const updateSalarioMax = (newVal:any) => {
  salarioMax.value = newVal
}
const updateNVacantes = (newVal:any) => {
  nVacantes.value = newVal
}
const updateDescfuncion = (newVal:any) => {
  descfuncion.value = newVal
}
const updateDescCarreras = (newVal:any) => {
  descCarreras.value = newVal
}
const updateFechaReque = (newVal:any) => {
  FechaReque.value = newVal
}
const updateSalarioMin = (newVal:any) => {
  salarioMin.value = newVal
}

let message = ref("");
let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);

async function submit() {
  try {
    if (!salarioMax.value || !salarioMin.value || !FechaReque.value || !descfuncion.value || !descCarreras.value || !nVacantes.value) {
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
        "DESCCARRERAS": descCarreras.value,
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
        <template v-slot:desc>We find the best people.<br> fecha: {{ currentDate }}</template>
      </LandingSectionhead>
    </template>
    <template #content>
      <InputsRequerimiento  propisDisable=false @update:salarioMax="updateSalarioMax" @update:salarioMin="updateSalarioMin" @update:nVacantes="updateNVacantes" @update:descfuncion="updateDescfuncion" @update:descCarreras="updateDescCarreras" @update:FechaReque="updateFechaReque"/>
    </template>
    <template #footer>
      <div class="flex justify-center align-middle gap-3 mt-1">
        <Button label="Save" @click="save" rounded severity="contrast" icon="pi pi-check" iconPos="right"
          class="text-white bg-black px-2 py-2"></Button>
      </div>
    </template>
  </Card>
  <div class="card flex flex-wrap items-center justify-center gap-3 mt-16">
    <InlineMessage v-if="isIncomplete" severity="error">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="alredyCreate" severity="warn">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="create" severity="success">{{ message }}</InlineMessage>
  </div>
</template>