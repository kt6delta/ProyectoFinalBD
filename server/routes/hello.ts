export default defineEventHandler((event) => {
    return {
      hello: process.env.PASSWORD,
    }
  })