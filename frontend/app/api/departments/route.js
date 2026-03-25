import { gqlFetch } from "@/lib/graphql-client";
import { NextResponse } from "next/server";

const DEPARTMENT_QUERY = `
    query DepartmentList {
        departments {
            description
            name
            id
            departmentHead {
                email
                name
            }
        }
    }
`


export async function GET() {
    try {
        const data = await gqlFetch(DEPARTMENT_QUERY)

        return NextResponse.json(
            {
                success: true,
                message: "Departments fetched successfully",
                data: data
            },
            { status: 200 }
        )
    } catch (error) {
        console.error('Department error:', error.message)
        return NextResponse.json({ error: error.message, ok: false }, { status: 500 })
    }
}   
