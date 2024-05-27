<script setup lang="ts">
definePageMeta({
  layout: "landing",
});
import { ref } from "vue";


async function generateEmployeeCode() {
  try {
    const response = await fetch('/generate-code', {
      method: 'GET'
    });

    const result = await response.json();
    if (response.ok) {
      localStorage.setItem('CODEMPLEADO', result.CODEMPLEADO);
      console.log('Código de empleado generado:', result.CODEMPLEADO);
    } else {
      console.error('Error al generar el código de empleado:', result.error);
    }
  } catch (error) {
    console.error('Error en la conexión:', error);
  }
}

const BtnItems = [
  {
    label: 'Update',
    icon: 'pi pi-refresh',
    command: () => {
      Update();
    }
  },
  {
    label: 'Delete',
    icon: 'pi pi-times',
    command: () => {
      Delete();
    }
  },
];

const save = () => {
  submit();
};

let message = ref("");
let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);
let cod = ref(null);
async function submit() {
  try {
    if (!nombre.value || !apellido.value || !born.value || !email.value || !selectedCargos.value) {
      message.value = "Faltan datos";
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
        "CARGO": selectedCargos.value
      }
    })
    if ((response as Response).status == 201) {
      message.value = "Empleado creado";
      create.value = true;
      setTimeout(() => {
        const router = useRouter();
        router.push('/');
      }, 2000);
    }
    if ((response as Response).status == 409) {
      message.value = "Ya existe un empleado";
      alredyCreate.value = true;
    }
  } catch (error) {
    console.error('Error during fetch:', error);
    message.value = "Error al crear empleado";
      isIncomplete.value = true;
  }
}


async function Update() {
  try {
    if (!cod.value || !nombre.value || !apellido.value || !born.value || !email.value || !selectedCargos.value) {
      message.value = "Faltan datos";
      isIncomplete.value = true;
      return;
    }
    await $fetch('/empleados', {
      method: 'PUT',
      body: {
        "CODEMPLEADO": cod.value as string,
        "NOMEMPLEADO": nombre.value,
        "APELLEMPLEADO": apellido.value,
        "FECHANAC": born.value,
        "CORREO": email.value,
        "CARGO": selectedCargos.value
      }
    })
    message.value = "Empleado actualizado";
    create.value = true;
  } catch (error) {
    console.error('Error during fetch:', error);
  }
}


async function Delete() {
  try {
    if (!cod.value) {
      message.value = "Faltan datos";
      isIncomplete.value = true;
      return;
    }
    await $fetch('/empleados', {
      method: 'DELETE',
      body: {
        "CODEMPLEADO": cod.value as string,
      }
    })
    message.value = "Empleado eliminado";
    create.value = true;
  } catch (error) {
    console.error('Error during fetch:', error);
    alredyCreate.value = true;
  }
}

const selectedCargos = ref();
let cargos = ref([await $fetch('/cargos')]);
cargos = cargos.value[0];
let nombre = ref("");
let apellido = ref("");
let born = ref(null);
let email = ref(null);
</script>

<template>
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
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText type="number" :min="0" placeholder="Codigo" v-model="cod" />
        </InputGroup>

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
          <InputText type="text" placeholder="Nombre" v-model="nombre" @input="nombre = nombre.toLowerCase()" />
        </InputGroup>

        <InputGroup>
          <InputGroupAddon class="bg-black text-white">
            <Icon name="material-symbols:person-outline" color="white" size="22" />
          </InputGroupAddon>
          <InputText placeholder="Apellido" v-model="apellido" @input="apellido = apellido.toLowerCase()" />
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
    <InlineMessage v-if="isIncomplete" severity="error">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="alredyCreate" severity="warn">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="create" severity="success">{{ message }}</InlineMessage>
  </div>
</template>