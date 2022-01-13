<?php declare(strict_types=1);

namespace Reconmap\Controllers\Clients;

use Reconmap\Controllers\UpdateEntityController;
use Reconmap\Models\AuditActions\ClientAuditActions;
use Reconmap\Repositories\ClientRepository;
use Reconmap\Services\ActivityPublisherService;
use Reconmap\Services\Security\AuthorisationService;

class UpdateClientController extends UpdateEntityController
{
    public function __construct(AuthorisationService $authorisationService, ActivityPublisherService $activityPublisherService, ClientRepository $repository)
    {
        parent::__construct($authorisationService, $activityPublisherService, $repository, 'client', ClientAuditActions::UPDATED, 'clientId');
    }
}
