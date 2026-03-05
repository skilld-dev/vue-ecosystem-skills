---
id: VideoStatusResult
title: VideoStatusResult
---

# Interface: VideoStatusResult

Defined in: types.ts:1085

**`Experimental`**

Status of a video generation job.

 Video generation is an experimental feature and may change.

## Properties

### error?

```ts
optional error: string;
```

Defined in: types.ts:1093

**`Experimental`**

Error message if status is 'failed'

***

### jobId

```ts
jobId: string;
```

Defined in: types.ts:1087

**`Experimental`**

Job identifier

***

### progress?

```ts
optional progress: number;
```

Defined in: types.ts:1091

**`Experimental`**

Progress percentage (0-100), if available

***

### status

```ts
status: "pending" | "processing" | "completed" | "failed";
```

Defined in: types.ts:1089

**`Experimental`**

Current status of the job
