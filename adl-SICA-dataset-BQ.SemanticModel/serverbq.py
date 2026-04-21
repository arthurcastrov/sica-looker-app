import asyncio
from mcp.server import Server
from mcp.server.stdio import stdio_server
from google.cloud import bigquery

client = bigquery.Client(project="adl-analytics-project")

server = Server(name="bigquery-mcp")

@server.list_tools()
def list_tools():
    return [
        {
            "name": "run_query",
            "description": "Ejecuta queries en BigQuery",
            "input_schema": {
                "type": "object",
                "properties": {
                    "query": {"type": "string"}
                },
                "required": ["query"]
            }
        }
    ]

@server.call_tool()
def handle_tool(name: str, arguments: dict):
    if name == "run_query":
        query = arguments.get("query")

        query_job = client.query(query)
        results = query_job.result()

        return [dict(row) for row in results]

    raise ValueError(f"Tool no soportada: {name}")

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream=read_stream,
            write_stream=write_stream,
            initialization_options={}
        )

if __name__ == "__main__":
    asyncio.run(main())