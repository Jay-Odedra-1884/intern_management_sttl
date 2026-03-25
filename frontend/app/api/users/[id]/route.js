const UPDATE_USER = `
mutation UpdateUser() {
update_users_by_pk(
    pk_columns: { id: "3f22d55a-bf0c-46a9-9391-53882724e0d8" }
    _set: { name: "Karan Desai", email: "", role:"" }
  ) {
    id
    name
    role
  }
}
`

export const POST = async (req, res) => {
    try {
        
    } catch (error) {
        console.error(error)
        return NextResponse.json({ok:false, error: error.message, message: "Something went wrong" }, { status: 500 });
    }
}