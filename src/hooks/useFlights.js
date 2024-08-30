import {
    useQuery
} from '@tanstack/react-query'
import {supabase} from "../supabaseClient.js";

const getFlights = async (search) => {
    const {data, error} = await supabase
        .from('reward_flight')
        .select('*, route!inner(arriving!inner(code), departing!inner(code)), currency(symbol)')
        .gte('date', search.when)
        .eq('route.departing.code', search.from)
        .eq('route.arriving.code', search.to)

    if (error) {
        throw new Error(error.message)
    }

    return data
}

export default function useFlights(search) {
    return useQuery({
        queryKey: ['flights', search],
        queryFn: () => getFlights(search),
        enabled: !!search
    })
}
