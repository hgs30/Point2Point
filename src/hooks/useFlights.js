import {
    useQuery
} from '@tanstack/react-query'
import {supabase} from "../supabaseClient.js";

const getFlights = async (search) => {
    const {data, error} = await supabase
        .from('reward_flight')
        .select()
        .gte('date', search.when)

    if (error) {
        throw new Error(error.message)
    }
    console.log(data)

    return data
}

export default function useFlights(search) {
    return useQuery({
        queryKey: ['flights'],
        queryFn: () => getFlights(search),
        enabled: !!search
    })
}
