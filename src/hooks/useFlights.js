import {
    useQuery
} from '@tanstack/react-query'
import {supabase} from "../supabaseClient.js";

const getFlights = async (search) => {
    const {data, error} = await supabase
        .from('reward_flight')
        .select('*, route(*, arriving_airport:route_arriving_fkey(code), departing_airport:route_departing_fkey(code)), currency(symbol)')
        .gte('date', search.when)
        .eq('route.departing_airport.code', search.from)
        .eq('route.arriving_airport.code', search.to)

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
