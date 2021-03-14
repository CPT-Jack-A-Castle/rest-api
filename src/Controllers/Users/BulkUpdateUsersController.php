<?php declare(strict_types=1);

namespace Reconmap\Controllers\Users;

use Psr\Http\Message\ServerRequestInterface;
use Reconmap\Controllers\Controller;
use Reconmap\Models\AuditLogAction;
use Reconmap\Repositories\UserRepository;
use Reconmap\Services\AuditLogService;

class BulkUpdateUsersController extends Controller
{
    public function __construct(private UserRepository $userRepository,
                                private AuditLogService $auditLogService)
    {
    }

    public function __invoke(ServerRequestInterface $request, array $args): array
    {
        $operation = $request->getHeaderLine('Bulk-Operation');
        $userIds = $this->getJsonBodyDecodedAsArray($request);

        $this->logger->debug("Bulk-Operation: $operation", $userIds);

        $numSuccesses = 0;

        if ('DELETE' === $operation) {
            $numSuccesses = $this->userRepository->deleteByIds($userIds);
        }

        $loggedInUserId = $request->getAttribute('userId');

        $this->auditAction($loggedInUserId, $userIds);

        return ['numSuccesses' => $numSuccesses];
    }

    private function auditAction(int $loggedInUserId, array $userIds): void
    {
        $this->auditLogService->insert($loggedInUserId, AuditLogAction::USER_DELETED, ['type' => 'users', 'ids' => $userIds]);
    }
}
