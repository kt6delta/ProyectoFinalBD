<script setup lang="ts">
definePageMeta({
  layout: "landing",
});

import { useToast } from "primevue/usetoast";
const toast = useToast();

const items = [
  {
    label: 'Update',
    icon: 'pi pi-refresh',
    command: () => {
      toast.add({ severity: 'success', summary: 'Updated', detail: 'Data Updated', life: 3000 });
    }
  },
  {
    label: 'Delete',
    icon: 'pi pi-times',
    command: () => {
      toast.add({ severity: 'warn', summary: 'Delete', detail: 'Data Deleted', life: 3000 });
    }
  },
];

const save = () => {
  toast.add({ severity: 'success', summary: 'Success', detail: 'Data Saved', life: 3000 });
};

import { ref } from "vue";

const selectedCity = ref();
const cities = ref([
    { name: 'New York', code: 'NY' },
    { name: 'Rome', code: 'RM' },
    { name: 'London', code: 'LDN' },
    { name: 'Istanbul', code: 'IST' },
    { name: 'Paris', code: 'PRS' }
]);
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
            <Dropdown v-model="selectedCity" :options="cities" optionLabel="name" placeholder="cargo" class="w-full md:w-[14rem]" />
          </InputGroup>

          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText placeholder="Nombre" />
          </InputGroup>

          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText placeholder="Apellido" />
          </InputGroup>

          <!-- input pequeños -->
          <div class="card flex flex-col md:flex-row gap-3">

            <InputGroup>
              <InputGroupAddon class="bg-black text-white">
                <Icon name="majesticons:calendar" color="white" size="22" />
              </InputGroupAddon>
              <Calendar dateFormat="dd/mm/yy" />
            </InputGroup>

            <InputGroup>
              <InputGroupAddon class="bg-black text-white">
                <Icon name="majesticons:calendar" color="white" size="22" />
              </InputGroupAddon>
              <Calendar dateFormat="dd/mm/yy" />
            </InputGroup>

            <InputGroup>
              <InputGroupAddon class="bg-black text-white">
                <Icon name="majesticons:calendar" color="white" size="22" />
              </InputGroupAddon>
              <Calendar dateFormat="dd/mm/yy" />
            </InputGroup>
          </div>
          <InputGroup>
            <InputGroupAddon class="bg-black text-white">
              <Icon name="ic:baseline-alternate-email" color="white" size="22" />
            </InputGroupAddon>
            <InputText placeholder="correo" />
          </InputGroup>
        </div>
      </template>
      <template #footer>
        <div class="flex justify-center align-middle gap-3 mt-1">
          <SplitButton label="Save" :model="items" @click="save" icon="pi pi-plus" rounded severity="contrast"
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