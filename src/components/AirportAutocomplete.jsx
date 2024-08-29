import {Autocomplete} from '@mantine/core';
import useAirports from "../hooks/useAirports.js";


function AirportAutocomplete() {
    const { data } = useAirports();


    return <Autocomplete label="Your favorite library"
                         placeholder="Pick value or enter anything" data={data}>
        {console.log(data)}
    </Autocomplete>
}

export default AirportAutocomplete
