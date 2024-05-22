<script setup lang="ts">
definePageMeta({
  layout: "landing",
});
import { ref } from "vue";

const BtnItems = [
  {
    label: 'Update',
    icon: 'pi pi-refresh',
    command: () => {
      const router = useRouter();
      router.push('/requerimiento');
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
  submit();
  //const router = useRouter();
  //router.push('/requerimiento');
};

let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);
async function submit() {
  try {
    if (!nombre.value || !apellido.value || !born.value || !email.value || !selectedCargos.value) {
      isIncomplete.value = true;
      return;
    }
    const response = await $fetch('/empleados', {
      method: 'POST',
      body: {
        "NOMEMPLEADO": nombre.value,
        "APELLEMPLEADO": apellido.value,
        "FECHANAC": born.value,
        "CORREO": email.value,
        "cargo": selectedCargos.value
      }
    })
    console.log(response);
    if (response.status === 409) {
      alredyCreate.value = true;
    }
    if (response.status === 201) {
      create.value = true;
    }
  } catch (error) {
    console.error('Error during fetch:', error);
  }
}


const selectedCargos = ref();
let cargos = ref([await $fetch('/cargos')]);
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
            <InputGroup>
              <InputGroupAddon class="bg-black text-white">
                <Icon name="majesticons:calendar" color="white" size="22" />
              </InputGroupAddon>
              <FloatLabel>
                <label for="label-nacimiento"> Nacimiento </label>
                <Calendar dateFormat="dd/mm/yy" v-model="born" />
              </FloatLabel>
            </InputGroup>
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
      <InlineMessage v-if="create" severity="success">Empleado creado correctamente</InlineMessage>
      <InlineMessage v-if="alredyCreate" severity="warn">Empleado ya existe</InlineMessage>
      <InlineMessage v-if="isIncomplete" severity="error">información faltante</InlineMessage>
    </div>
  </LandingContainer>
</template>