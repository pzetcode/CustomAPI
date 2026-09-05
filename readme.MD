# CustomAPI

A Microsoft Dynamics 365 Business Central extension for reading values from a JSON REST API and displaying selected array properties in Business Central.

## Features

- Configure multiple API endpoints with a unique API code.
- Send an HTTP `GET` request with `Accept: application/json`.
- Browse the JSON response and inspect parsed nodes.
- Select properties from one JSON array scope.
- Automatically create a mapping for the selected properties.
- Retrieve and display up to 100 array records in a temporary Business Central list.

## Requirements

- Microsoft Dynamics 365 Business Central 2026 release wave 1 or a compatible environment using application version `28.0.0.0`.
- AL development environment with the matching Business Central symbols.
- Network access from the Business Central service tier to the target API.
- An API endpoint that returns a JSON object containing an array of JSON objects.

## Installation

1. Clone or download this repository.
2. Open the project folder in Visual Studio Code with the AL Language extension installed.
3. Configure the Business Central server and launch configuration for your target environment.
4. Download symbols if required.
5. Build and publish the extension to your Business Central environment.
6. Search for **Custom API Setup** in Business Central.

The packaged extension is also available as `Default Publisher_CustomAPI_1.0.0.0.app`.

## Configuration and usage

1. Open **Custom API Setup** and create a new record.
2. Enter a unique **API Code**.
3. Enter the API **URL**.
4. Optionally enter a description and adjust **Limit Records**. The allowed range is 1 to 100 and the default is 10.
5. Select **Display nodes** to inspect the parsed JSON response.
6. Select **Select array nodes (one array scope)**.
7. Select the value nodes that should be returned. All selected nodes must belong to the same array.
8. Select **Show array mapping** to review the selected properties.
9. Select **Get values from API** to call the endpoint and display the extracted values.

The resulting values are shown in the **Custom API Values** page in columns `Value1` through `Value10`.

## Expected response format

The response should contain an array of objects. For example:

```json
{
  "products": [
    {
      "id": "1001",
      "name": "Example product",
      "status": "Active"
    }
  ]
}
```

For this response, select `id`, `name`, and `status` from the `products` array. The extension stores `products` as the array root and displays the selected properties in the corresponding value columns.

## Limitations

- Only HTTP `GET` requests are currently supported.
- Authentication headers, query configuration, pagination, and request bodies are not configured by the extension.
- The response must contain an array of JSON objects.
- Selected properties must be in the same array scope.
- A maximum of 10 properties can be mapped and displayed.
- Values are displayed temporarily and are not persisted as business data.
- API values are converted to text and truncated to the destination field size when necessary.

## Project structure

```text
src/
  codeunit/   API request, JSON parsing, mapping, and value extraction
  page/       Setup, JSON node, mapping, and result pages
  table/      Setup, parsed JSON, mapping, and result tables
Translations/ XLF translation file
app.json     AL extension metadata
```

## License

No license has been specified for this project yet.
