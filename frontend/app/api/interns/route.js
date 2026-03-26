import { NextResponse } from 'next/server'
import { gqlFetch } from '@/lib/graphql-client'
import { requireAuth } from '@/lib/middleware/RequireRole'

const GET_INTERNS = `
  query GetInterns($where: interns_bool_exp!) {
    interns(order_by: { created_at: desc }, where: $where) {
      id status start_date end_date college position_title created_at
      userByUserId { name email }
      department   { name head_user_id }
      user         { name }
    }
  }
`

export async function GET(req) {
  const session = await requireAuth(req, ["admin", "manager", "mentor"])
  if (!session) return NextResponse.json({ error: "Unauthorized", ok: false }, { status: 401 })

  try {
    let where = {}
    if (session.user.role === "manager" || session.user.role === "mentor") {
      where = { 
        _or: [
          { department: { head_user_id: { _eq: session.user.id } } },
          { mentor_id: { _eq: session.user.id } }
        ]
      }
    }

    const data = await gqlFetch(GET_INTERNS, { where })
    return NextResponse.json(data ?? { interns: [] })
  } catch (error) {
    console.error('Interns error:', error.message)
    return NextResponse.json({ interns: [] }, { status: 200 })
  }
}