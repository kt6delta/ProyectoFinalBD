<template>
  <div class="bg-slate-300 min-h-screen min-w-screen">
    <LandingNavbar :Propempleado="empleado" />
    <LandingContainer>
      <slot :updateEmpleado="updateEmpleado"></slot>
    </LandingContainer>
    <LandingFooter />
  </div>
</template>

<script>
import { ref } from "vue";

export default {
  setup() {
    let empleado = ref("Anonimo");
    const updateEmpleado = (newEmpleado) => {
      empleado.value = newEmpleado;
    };

    return {
      empleado,
      updateEmpleado
    };
  }
};
</script>