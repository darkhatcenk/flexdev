{{ Illuminate\Mail\Markdown::parse('---') }}

Thank you,<br>
{{ config('app.name') ?? 'FlexDEV' }}

{{ Illuminate\Mail\Markdown::parse('[Contact Support](https://flexdev.io/docs/contact)') }}
