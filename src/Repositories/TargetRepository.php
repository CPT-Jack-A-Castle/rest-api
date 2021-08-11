<?php declare(strict_types=1);

namespace Reconmap\Repositories;

use Reconmap\Models\Target;
use Reconmap\Repositories\QueryBuilders\SearchCriteria;
use Reconmap\Repositories\QueryBuilders\SelectQueryBuilder;
use Reconmap\Services\RequestPaginator;

class TargetRepository extends MysqlRepository implements Findable
{
    public function findById(int $id): ?array
    {
        $queryBuilder = $this->getBaseSelectQueryBuilder();
        $queryBuilder->setWhere('t.id = ?');
        $stmt = $this->db->prepare($queryBuilder->toSql());
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $target = $result->fetch_assoc();
        $stmt->close();

        return $target;
    }

    public function findByProjectId(int $projectId): array
    {
        $queryBuilder = $this->getBaseSelectQueryBuilder();
        $queryBuilder->setWhere('t.project_id = ?');
        $stmt = $this->db->prepare($queryBuilder->toSql());

        $stmt->bind_param('i', $projectId);
        $stmt->execute();
        $result = $stmt->get_result();
        $targets = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $targets;
    }

    public function findByProjectIdAndName(int $projectId, string $name): ?object
    {
        $queryBuilder = $this->getBaseSelectQueryBuilder();
        $queryBuilder->setWhere('t.project_id = ? AND t.name = ?');

        $stmt = $this->db->prepare($queryBuilder->toSql());
        $stmt->bind_param('is', $projectId, $name);
        $stmt->execute();
        $result = $stmt->get_result();
        $target = $result->fetch_object();
        $stmt->close();

        return $target;
    }

    public function search(SearchCriteria $searchCriteria, ?RequestPaginator $paginator = null): array
    {
        $queryBuilder = $this->getBaseSelectQueryBuilder();
        return $this->searchAll($queryBuilder, $searchCriteria, $paginator);
    }

    public function countSearch(SearchCriteria $searchCriteria): int
    {
        $queryBuilder = $this->getBaseSelectQueryBuilder();
        $queryBuilder->setColumns('COUNT(*) AS total');
        $results = $this->searchAll($queryBuilder, $searchCriteria);
        return $results[0]['total'];
    }

    public function deleteById(int $id): bool
    {
        return $this->deleteByTableId('target', $id);
    }

    public function insert(Target $target): int
    {
        $stmt = $this->db->prepare('INSERT INTO target (project_id, name, kind) VALUES (?, ?, ?)');
        $stmt->bind_param('iss', $target->projectId, $target->name, $target->kind);
        return $this->executeInsertStatement($stmt);
    }

    private function getBaseSelectQueryBuilder(): SelectQueryBuilder
    {
        $queryBuilder = new SelectQueryBuilder('target t');
        $queryBuilder->setColumns('
            t.*,
            (SELECT COUNT(*) FROM vulnerability WHERE target_id = t.id) AS num_vulnerabilities
        ');
        $queryBuilder->setOrderBy('t.insert_ts DESC, t.name ASC');
        return $queryBuilder;
    }
}
