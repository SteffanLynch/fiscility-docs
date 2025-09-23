// index.tsx
const ENDPOINT_URL = process.env.ENDPOINT_URL;
const SCHEDULE_TRIGGER_SECRET = process.env.SCHEDULE_TRIGGER_SECRET;

const schedule = "daily";

try {
  const response = await fetch(
    `${ENDPOINT_URL}/api/internal/reports/${schedule}`,
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${SCHEDULE_TRIGGER_SECRET}`,
      },
    }
  );

  if (!response.ok) {
    throw new Error(response.statusText);
  }

  const data = (await response.json()) as { count: number };
  console.log(
    `Successfully sent ${data.count} reports: ${JSON.stringify(data)}`
  );
} catch (e) {
  console.log(`Failed to send report data: ${e}`);
}
