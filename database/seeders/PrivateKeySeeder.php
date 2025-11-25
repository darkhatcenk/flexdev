<?php

namespace Database\Seeders;

use App\Models\PrivateKey;
use Illuminate\Database\Seeder;

class PrivateKeySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        PrivateKey::create([
            'team_id' => 0,
            'name' => 'Testing Host Key',
            'description' => 'This is a test docker container',
            'private_key' => "TEST_OPENSSH_KEY_LINE_1\nTEST_OPENSSH_KEY_LINE_2\nTEST_OPENSSH_KEY_LINE_3\nTEST_OPENSSH_KEY_LINE_4\nTEST_OPENSSH_KEY_LINE_5",
        ]);

        PrivateKey::create([
            'team_id' => 0,
            'name' => 'development-github-app',
            'description' => 'This is the key for using the development GitHub app',
            'private_key' => "TEST_RSA_KEY_LINE_1\nTEST_RSA_KEY_LINE_2\nTEST_RSA_KEY_LINE_3\nTEST_RSA_KEY_LINE_4\nTEST_RSA_KEY_LINE_5\nTEST_RSA_KEY_LINE_6\nTEST_RSA_KEY_LINE_7\nTEST_RSA_KEY_LINE_8",
            'is_git_related' => true,
        ]);
    }
}
