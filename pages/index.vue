<script setup lang="ts">
definePageMeta({
    layout: "landing",
});

import { ref } from "vue";
let message = ref("");
let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);
const selectedCargos = ref();
let cargos = ref([await $fetch('/cargos')]);
cargos = cargos.value[0];
let nombre = ref(null);
let apellido = ref(null);
let born = ref(null);
let email = ref(null);

const save = () => {
    submit();
};

async function submit() {
    try {
        if (!nombre.value || !apellido.value || !born.value || !email.value || !selectedCargos.value) {
            message.value = "Faltan datos";
            isIncomplete.value = true;
            return;
        }
        const response = await $fetch('/empleados/login', {
            method: 'POST',
            body: {
                "NOMEMPLEADO": nombre.value,
                "APELLEMPLEADO": apellido.value,
                "FECHANAC": born.value,
                "CORREO": email.value,
                "cargo": selectedCargos.value
                
            }
        })
        if ((response as Response).status === 201) {
            create.value = true;
            message.value = "Empleado logeado correctamente";
            const username = nombre.value;
            setTimeout(() => {
                const router = useRouter();
                router.push(`/requerimiento/${username}`);

            }, 3000);
        }
        if ((response as Response).status === 404) {
            alredyCreate.value = true;
            message.value = "No existe el empleado";
        }
    } catch (error) {
        console.error('Error during fetch:', error);
    }
}

</script>

<template>
    <Card class="mt-[5vh]" style="overflow: hidden">
        <template #header>
            <LandingSectionhead>
                <template v-slot:title>Login Empleado</template>
                <template v-slot:desc>Just Do it!.</template>
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
                <Button label="Save" @click="save" icon="pi pi-check" rounded severity="contrast"
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