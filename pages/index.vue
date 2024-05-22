<script setup lang="ts">
definePageMeta({
  layout: "landing",
});


const BtnItems = [
  {
    label: 'Update',
    icon: 'pi pi-refresh',
    command: () => {
      const router = useRouter();
      router.push('/requerimiento');
      console.log('update');
    }
  },
  {
    label: 'Delete',
    icon: 'pi pi-times',
    command: () => {
      const router = useRouter();
      router.push('/requerimiento');
      console.log('delete');
    }
  },
];

const save = () => {
  const router = useRouter();
  router.push('/requerimiento');
};

import { ref } from "vue";

const selectedCargos = ref();
let cargos = ref([await $fetch('/empleados')]);
cargos = cargos.value[0];

let nombre = ref(null);
let apellido = ref(null);
let born = ref(null);
let email = ref(null);
const search = ref();
const value = ref();
</script>

<template>
  <LandingContainer>
    <Card class="mt-[5vh]" style="overflow: hidden">
      <template #header>
        <LandingSectionhead>
          <template v-slot:title>Registro Empleado</template>
          <template v-slot:desc>We are here to help.</template>
        </LandingSectionhead>
      </template>
      <template #content>
        <div class="grid md:grid-cols-2 gap-10 mx-auto max-w-4xl mt-16">
          <!-- input General -->
          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="mdi:company" color="white" size="22" />
            </InputGroupAddon>
            <Dropdown v-model="selectedCargos" :options="cargos" optionLabel="name" placeholder="cargo"
              class="w-full md:w-[14rem]" />
          </InputGroup>

          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="text" placeholder="Nombre" v-model="nombre" />
          </InputGroup>

          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText placeholder="Apellido" v-model="apellido" />
          </InputGroup>

          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="ic:baseline-alternate-email" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="email" placeholder="correo" v-model="email" />
          </InputGroup>

          <div class="card flex flex-col md:flex-row gap-3">
            <div class="flex-auto">
              <label for="buttondisplay" class="block mb-2"> Nacimiento </label>
              <InputGroup>
                <InputGroupAddon class="bg-black text-white">
                  <Icon name="majesticons:calendar" color="white" size="22" />
                </InputGroupAddon>
                <Calendar dateFormat="dd/mm/yy" v-model="born" />
              </InputGroup>
            </div>
          </div>

        </div>
      </template>
      <template #footer>
        <div class="flex justify-center align-middle gap-3 mt-1">
          <SplitButton label="Save" :model="BtnItems" @click="save" icon="pi pi-plus" rounded severity="contrast"
            class="text-white bg-black px-2 py-2"></SplitButton>
        </div>
      </template>
    </Card>
    <div class="card flex flex-wrap items-center justify-center gap-3 mt-16">
      <InlineMessage severity="success">Success Message</InlineMessage>
      <InlineMessage severity="warn">Warning Message</InlineMessage>
      <InlineMessage severity="error">Error Message</InlineMessage>
    </div>
  </LandingContainer>
</template>