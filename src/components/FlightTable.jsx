import { Table } from '@mantine/core';
import useFlights from "../hooks/useFlights.js";

function FlightTable() {
    const { data, isLoading, error } = useFlights();

    if (isLoading) return <div>Loading...</div>;
    if (error) return <div>Error: {error.message}</div>;

    const rows = data?.map((flight) => (
        <Table.Tr key={flight.id}>
            <Table.Td>{flight.points}</Table.Td>
            <Table.Td>{flight.taxes}</Table.Td>
            <Table.Td>{flight.currency}</Table.Td>
            <Table.Td>{flight.date}</Table.Td>
        </Table.Tr>
    ));

    return (<>
            <Table>
                <Table.Thead>
                    <Table.Tr>
                        <Table.Th>Points</Table.Th>
                        <Table.Th>Taxes</Table.Th>
                        <Table.Th>Currency</Table.Th>
                        <Table.Th>Date</Table.Th>
                    </Table.Tr>
                </Table.Thead>
                <Table.Tbody>{rows}</Table.Tbody>
            </Table>
    </>

    );
}

export default FlightTable
