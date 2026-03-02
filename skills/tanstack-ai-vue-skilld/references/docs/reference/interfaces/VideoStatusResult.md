---
id: VideoStatusResult
title: VideoStatusResult
---

# Interface: VideoStatusResult

Defined in: types.ts:1057

**`Experimental`**

Status of a video generation job.

 Video generation is an experimental feature and may change.

## Properties

### error?

```ts
optional error: string;
```

Defined in: types.ts:1065

**`Experimental`**

Error message if status is 'failed'

***

### jobId

```ts
jobId: string;
```

Defined in: types.ts:1059

**`Experimental`**

Job identifier

***

### progress?

```ts
optional progress: number;
```

Defined in: types.ts:1063

**`Experimental`**

Progress percentage (0-100), if available

***

### status

```ts
status: "pending" | "processing" | "completed" | "failed";
```

Defined in: types.ts:1061

**`Experimental`**

Current status of the job
