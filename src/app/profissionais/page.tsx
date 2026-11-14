import { Suspense } from "react";
import { connection } from "next/server";
import { db } from "@/prisma/db";

async function ProfessionalList() {
  await connection(); 

  const professionals = await db.orm.public.Professional.select(
    "id",
    "name",
    "specialty",
  )
    .limit(50)
    .all();

  const sorted = [...professionals].sort((a, b) =>
    a.name.localeCompare(b.name),
  );

  return (
    <ul className="space-y-3">
      {sorted.map((p) => (
        <li key={p.id} className="rounded-lg bg-zinc-900 p-4">
          <p className="font-semibold">{p.name}</p>
          {p.specialty && (
            <p className="text-sm text-zinc-400">{p.specialty}</p>
          )}
        </li>
      ))}
    </ul>
  );
}

export default function ProfissionaisPage() {
  return (
    <main className="mx-auto max-w-3xl p-6">
      <h1 className="mb-6 text-3xl font-bold">Profissionais</h1>
      <Suspense fallback={<p>Carregando...</p>}>
        <ProfessionalList />
      </Suspense>
    </main>
  );
}
