import {
    useQuery
} from '@tanstack/react-query'
import {supabase} from "../supabaseClient.js";

const getAirports = async () => {
    const {data, error} = await supabase
        .from('airport')
        .select('code, city(name, country(name))')

    if (error) {
        throw new Error(error.message)
    }

    return data.map(row => {
        return {
            value: row.code,
            label: `${row.code} (${row.city.name}, ${row.city.country.name})`
        }
    })
}

export default function useAirports() {
    return useQuery({queryKey: ['airports'], queryFn: getAirports})
}
